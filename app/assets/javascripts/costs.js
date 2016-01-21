
$('#rmb_input').on('change', function () {
  RMB = $(this).val();
  USD = RMB*6;
  $('#usd_output').val(USD);
});