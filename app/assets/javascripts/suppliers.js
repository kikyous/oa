(function() {
  jQuery(function() {
    return $('#suppliers').dataTable({
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#suppliers').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        /* Need to redo the counters if filtered or sorted */
        // if ( oSettings.bSorted || oSettings.bFiltered )
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/suppliers/'+item.text()+'/edit>[修改]</a> '+' <a href=/suppliers/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
             this.parentNode, 3, false, false );
          } );
        }
      },
      "aoColumnDefs": [
        { "bSortable": false, "aTargets": [ 3 ] }
      ],

    });
  });
}).call(this);

$(function(){

$("#suppliers_filter").append(" <a href=/suppliers/new >新增</a>")

})
