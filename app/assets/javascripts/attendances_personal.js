$(function(){
    showConfirm=false;
    var oTable = $('#attendances').dataTable({
        sAjaxSource: $('#attendances').data('source'),
        "fnDrawCallback": function ( oSettings ) {
            var that = this;
            var item=this.$('td:last-child');
            if (item.length==0 && showConfirm ){
                console.log(0);
            }
            else{
                showConfirm=false;
                item.each( function (i,e) {
                    var item=$(e);
                    that.fnUpdate('<a href=/attendances/'+item.text()+'>[查看]</a> '+' <a href=/attendances/'+item.text()+'>[下载]</a>' ,
                    this.parentNode, 5, false, false );
                } );
            }
        },
        "aoColumnDefs": [
            { "bSortable": false, "aTargets": [ 5 ] }
        ],

    });
});
