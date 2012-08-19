$(function(){
    showConfirm=false;
    var oTable = $('#attendances').dataTable({
        sAjaxSource: $('#attendances').data('source'),
        "fnDrawCallback": function ( oSettings ) {
            var that = this;
            var item=this.$('td:last-child');
            if (item.length==0 && showConfirm ){
                console.log(0);
                if (confirm("本月暂无考勤信息，是否新建？")){
                $("#attendances td").text("请稍候...");
                $.ajax({type: 'POST',
                    "url":"/attendances/create_all",
                    data:{'for_month':getValue()},
                dataType:'script'});
                };
                showConfirm=false;
            }
            else{
                showConfirm=false;
                item.each( function (i,e) {
                    var item=$(e);
                    that.fnUpdate('<a href=/attendances/'+item.text()+'/edit>[编辑]</a> '+' <a href=/attendances/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
                    this.parentNode, 5, false, false );
                } );
            }
        },
        "aoColumnDefs": [
            { "bSortable": false, "aTargets": [ 5 ] }
        ],

    });
    $("#attendances_filter>label").append(" <a href=/attendances/new >新增</a>");

    var cur = new Date();
    var year = cur.getFullYear();

    var element="<select id='year'>";
    for (var init=year;init>=2010;init--)
    {
        element+="<option value=" +init+ ">" +init+ "</option>"
    };
    element+="</select>年 <select id='month'>";
    for (var init=1;init<=12;init++)
    {
        element+="<option value=" +init+ ">" +init+ "</option>"
    };
    element+="</select>月 ";

    $("#attendances_length>label").prepend(element);
    $("#year").val(year);

    filter=function (value,setValue) {
        oTable.fnFilter(value,1);
        if (setValue){
            var y=value.split("-")[0];
            var m=value.split("-")[1];
            $("#month").val(m.replace(/^0/,''));
            $("#year").val(y);
        }
    };
    getValue=function(){
        var month=$("#month").val();
        var year=$("#year").val();
        if (month.length==1) month="0"+month;
        return year+'-'+month;
    };
    $("#month,#year").change( function(){ 
        showConfirm=true;
        filter(getValue(),false);
    } );
    $.ajax({url:'/attendances.js', dataType: 'script'} );
});
