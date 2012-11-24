(function() {
  jQuery(function() {
    return $('#in_comes').dataTable({
      sAjaxSource: $('#in_comes').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/in_comes/'+item.text()+'/edit>[修改]</a> '+' <a href=/in_comes/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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
$("#in_comes_filter>label").append(" <a href=/in_comes/new ><i class='icon-plus'></i>新增</a>")
})
