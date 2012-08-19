(function() {
  jQuery(function() {
    return $('#acceptances').dataTable({
      sAjaxSource: $('#acceptances').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/acceptances/'+item.text()+'/edit>[修改]</a> '+' <a href=/acceptances/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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
