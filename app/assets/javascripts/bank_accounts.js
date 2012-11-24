(function() {
  jQuery(function() {
    return $('#bank_accounts').dataTable({
      sAjaxSource: $('#bank_accounts').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/bank_accounts/'+item.text()+'/edit>[修改]</a> '+' <a href=/bank_accounts/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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
$("#bank_accounts_filter>label").append("<a href=/bank_accounts/new ><i class='icon-plus'></i>新增</a>")
})
