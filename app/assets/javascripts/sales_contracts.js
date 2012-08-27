(function() {
  jQuery(function() {
    return $('#sales_contracts').dataTable({
      sAjaxSource: $('#sales_contracts').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/sales_contracts/'+item.text()+'/edit>[修改]</a> '+' <a href=/sales_contracts/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
             this.parentNode, 5, false, false );
          } );
        }
      },
      "aoColumnDefs": [
        { "bSortable": false, "aTargets": [ 5 ] }
      ],

    });
  });
}).call(this);

$(function(){

$("#sales_contracts_filter>label").append(" <a href=/sales_contracts/new ><i class='icon-plus'></i>新增</a>")

})
