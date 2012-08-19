(function() {
  jQuery(function() {
    return $('#notes').dataTable({
      sAjaxSource: $('#notes').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/notes/'+item.text()+'/edit>[修改]</a> '+' <a href=/notes/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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

$("#notes_filter>label").append("<a href=/notes/new ><i class='icon-plus'></i>新增</a>")

})
