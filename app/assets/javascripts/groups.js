(function() {
  jQuery(function() {
    return $('#groups').dataTable({
      sAjaxSource: $('#groups').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/groups/'+item.text()+'/edit>[修改]</a> '+' <a href=/groups/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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

$("#groups_filter>label").append(" <a href=/groups/new ><i class='icon-plus'></i>新增</a>")

})
