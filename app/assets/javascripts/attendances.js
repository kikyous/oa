$(function(){
    showConfirm=false;
    var oTable = $('#attendances').dataTable({
        sPaginationType: "full_numbers",
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $('#attendances').data('source'),
        "fnDrawCallback": function ( oSettings ) {
            var that = this;
            var item=this.$('td:last-child');
            if (item.length==0 && showConfirm ){
                console.log(0);
                if (confirm("本月暂无考勤信息，是否新建？")){
                $("#attendances td").text("请稍候...");
                $.ajax({type: 'POST',
                    "url":"/attendances",
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
                    this.parentNode, 4, false, false );
                } );
            }
        },
        "aoColumnDefs": [
            { "bSortable": false, "aTargets": [ 4 ] }
        ],

    });
    $("#attendances_filter").append(" <a href=/attendances/new >新增</a>");

    var cur = new Date();
    var year = cur.getFullYear();

    var element="<select id='year'>";
    for (var init=2012;init<=year;init++)
    {
        element+="<option value=" +init+ ">" +init+ "</option>"
    };
    element+="</select>年 <select id='month'>";
    for (var init=1;init<=12;init++)
    {
        element+="<option value=" +init+ ">" +init+ "</option>"
    };
    element+="</select>月 ";

    $("#attendances_length").prepend(element);

    filter=function (value,setValue) {
        oTable.fnFilter(value,1);
        if (setValue){
            $("#month").val(value.split("-")[1].split('0').reverse()[0]);
            $("#year").val(value.split("-")[0]);
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
