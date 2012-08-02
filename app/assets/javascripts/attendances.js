(function() {
  jQuery(function() {
    return $('#attendances').dataTable({
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#attendances').data('source'),
      "fnDrawCallback": function ( oSettings ) {
        var that = this;
        /* Need to redo the counters if filtered or sorted */
        // if ( oSettings.bSorted || oSettings.bFiltered )
        {
          this.$('td:last-child').each( function (i,e) {
            var item=$(e);
            that.fnUpdate('<a href=/attendances/'+item.text()+'/edit>[修改]</a> '+' <a href=/attendances/'+item.text()+' data-confirm="确定删除 ?" data-method="delete" rel="nofollow">[删除]</a>' ,
            
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
$("#attendances_filter").append(" <a href=/attendances/new >新增</a>");

var cur = new Date();
var year = cur.getFullYear();

var element="<select>";
for (var init=2012;init<=year;init++)
{
  element+="<option value=" +init+ ">" +init+ "</option>"
};
element+="</select>年 <select>";
for (var init=1;init<=12;init++)
{
  element+="<option value=" +init+ ">" +init+ "</option>"
};
element+="</select>月 ";

$("#attendances_length").prepend(element);

})
