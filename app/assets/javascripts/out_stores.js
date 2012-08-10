(function() {
  jQuery(function() {
    return $('#out_stores').dataTable({
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#out_stores').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/out_stores/'+item.text()+'/edit>[修改]</a> '+' <a href=/out_stores/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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

$("#out_stores_filter").append(" <a href=/out_stores/new >新增</a>")

})
