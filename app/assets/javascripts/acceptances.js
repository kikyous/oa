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
            
<<<<<<< HEAD
             this.parentNode, 6, false, false );
=======
             this.parentNode, 5, false, false );
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
          } );
        }
      },
      "aoColumnDefs": [
<<<<<<< HEAD
        { "bSortable": false, "aTargets": [ 6 ] }
=======
        { "bSortable": false, "aTargets": [ 5 ] }
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
      ],

    });
  });
}).call(this);
