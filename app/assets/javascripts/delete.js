$(document).on('turbolinks:load', ()=> {

  $('.items').on('click', '.delete', function(e) {
    
    let id = $(this).prop('id');
    let deleteUrl = '/items/' + id;

    $.ajax({
      url: deleteUrl,
      type: "DELETE",
      data: {id: id},
      dataType: 'json'
    }).done(function (data) {
      console.log("success");
      $('#' + id).parent().parent().remove();
    })
    .fail(function () {
      alert('delete error');
    })

  });

});
