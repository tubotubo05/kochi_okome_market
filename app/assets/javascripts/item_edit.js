document.addEventListener('turbolinks:load', function () {

  if (!$('.button__edit')[0]) return false;

  function buildFileField(index) {
    const html = `<div class="file" data-index="${index}">
                    <input id="img-file${index}" class="file__image" type="file"
                    name="item[item_images_attributes][${index}][image_url]" data-index="${index}">
                    <label class="label" for="img-file${index}">
                      <i class="fas fa-camera icon"></i>
                    </label>
                  </div>`;
    return html;
  }

  $('.field').append(buildFileField($(".previews__field").length));

  if($(".file").length = 6){
    $(".file").eq(5).hide();
  }

});