(function() {
  jQuery(function() {
    return $('#in_stores').dataTable({
      sAjaxSource: $('#in_stores').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/in_stores/'+item.text()+'/edit>[修改]</a> '+' <a href=/in_stores/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
             this.parentNode, 2, false, false );
          } );
        }
      },
      "aoColumnDefs": [
        { "bSortable": false, "aTargets": [ 2 ] }
      ],

    });
  });
}).call(this);

$(function(){

$("#in_stores_filter>label").append(" <a href=/in_stores/new >新增</a>")

})
