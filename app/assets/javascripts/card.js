document.addEventListener('turbolinks:load', function () {
  if (!$('#card_form')[0]) return false;
  
  Payjp.setPublicKey("pk_test_94742f6ab799c37062db6a64");

  const regist_button = $("#regist_card");

  regist_button.on("click", function (e) {
    e.preventDefault();
    const card = {
      number: $('#card_number_form').val(),
      cvc: $('#cvc_form').val(),
      exp_month: $('#exp_month_form').val(),
      exp_year: $('#exp_year_form').val()
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        alert("カードを登録しました");
        $("#card_token").append(`<input type="hidden" name="payjp_token" value=${response.id}>`);
        $("#card_number_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");
        $('#card_form')[0].submit();
      } else {
        alert("カード情報が正しくありません。");
        console.log(response.error.message);
        regist_button.prop('disabled', false);
      }
    });

  });

  

});