document.addEventListener('turbolinks:load', function () {

  if (!$('.previews__field')[0]) return false;

  function buildCategoryForm(categories) {
    let options = "";
    if(categories[0].ancestry.indexOf("/", 0) == -1){
      relation = "child";
    } else {
      relation = "grandchild";
    }
    categories.forEach(function (category) {
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });
    const html = `
                  <br>
                  <select required="required" class="select-category ${relation}" id="parent-category" name="item[category_${relation}]">
                    <option value="${relation}">選択してください</option>
                    ${options}
                  </select>
                 `;
    return html;
  }

  function displaySelectBox(id, relationship) {
    $.ajax({
      url: '/api/categories',
      type: "GET",
      data: {
        category_id: id
      },
      dataType: 'json',
    }).done(function (categories) {
      const html = buildCategoryForm(categories.array);
      $(".select-category:last").after(html);
      if(relationship == "grandchild"){
        $(".grandchild").val(category_id);
      }
    })
    .fail(function () {
      alert('error');
    })
  }

  const category_id = $('.select-category').attr('id');
  let ancestry = $('.select-category').data('ancestry');

  if(ancestry != "nil"){
    $.ajax({
      url: '/api/categories/new',
      type: "GET",
      data: {
        category_id: category_id
      },
      dataType: 'json',
    }).done(function (categories) {
      if(categories.select.ancestry != null) {
        $.ajax({
          url: '/api/categories/new',
          type: "GET",
          data: {
            category_id: categories.select.id
          },
          dataType: 'json',
        }).done(function (categories_grandchild) {
          let parent_id = String(categories_grandchild.select.id)
          $(".parent").val(parent_id);
          const html = buildCategoryForm(categories_grandchild.array);
          $(".select-category:last").after(html);
          $(".child").val(categories.select.id);
          displaySelectBox(categories.select.id, "grandchild");
        })
        .fail(function () {
          alert('error');
        })
      } else {
        let parent_id = String(categories.select.id)
        $(".parent").val(parent_id);
        const html = buildCategoryForm(categories.array);
        $(".select-category:last").after(html);
        $(".child").val(category_id);
        displaySelectBox(category_id, "child");
      }
    })
    .fail(function () {
      alert('error');
    })
  } else {
    $(".parent").val(category_id);
    displaySelectBox(category_id);
  }
  
  
});
