$(document).on('turbolinks:load', ()=> {

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
  function buildImg(index, url) {
    const html = `<div data-index="${index}" class="previews__field previews__field${index}">
                    <img data-index="${index}" src="${url}" width="110px" height="100px">
                    <div class="previews__field__button">
                      <div class="remove">削除</div>
                    </div>
                  </div>`;
    return html;
  }

  let existCount = [];

  $('.top__image__upload').on('change', '.file__image', function(e) {
    
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {

      $(`.file[data-index="${targetIndex}"]`).hide();

      existCount.push(targetIndex);
      $('.previews').append(buildImg(targetIndex, blobUrl));
      $('.field').append(buildFileField(targetIndex+1));

      if(existCount.length == 5){
        $(`.file[data-index="${targetIndex+1}"]`).hide();
      }
    }
  });

  $('.top__image__upload').on('click', '.remove', function() {
    $(this).parent().parent().remove();
    let targetIndex = $(this).parent().parent().data('index');
    $(`div[data-index="${targetIndex}"]`).remove();

    var c = existCount.indexOf(targetIndex);
    if (c > -1) {
      existCount.splice(c, 1);
    }
    if(existCount.length == 4){
      $(`.file[data-index="${$('.file').eq(4).data('index')}"]`).show();
    }
  });

});


