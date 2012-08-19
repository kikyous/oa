(function() {
  jQuery(function() {
    return $('#transfers').dataTable({
      sAjaxSource: $('#transfers').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/transfers/'+item.text()+'/edit>[修改]</a> '+' <a href=/transfers/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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

$("#transfers_filter>label").append(" <a href=/transfers/new >新增</a>")

})
