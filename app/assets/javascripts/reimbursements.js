(function() {
  jQuery(function() {
    return $('#reimbursements').dataTable({
      sAjaxSource: $('#reimbursements').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/reimbursements/'+item.text()+'/edit>[修改]</a> '+' <a href=/reimbursements/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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

$(function(){

$("#reimbursements_filter>label").append(" <a href=/reimbursements/new >新增</a>")

})
