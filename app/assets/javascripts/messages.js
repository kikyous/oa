(function() {
  jQuery(function() {
    return $('#messages').dataTable({
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#messages').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        /* Need to redo the counters if filtered or sorted */
        // if ( oSettings.bSorted || oSettings.bFiltered )
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/messages/'+item.text()+'>[回复]</a> '+' <a href=/messages/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
             this.parentNode, 4, false, false );
          } );
        }
      },
      "aoColumnDefs": [
        { "bSortable": false, "aTargets": [ 4 ] }
      ],

    });
  });
}).call(this);

$(function(){

$("#messages_filter").append(" <a href=/messages/new >新增</a>")

})

