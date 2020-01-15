$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();

  $('#owl-demo').owlCarousel({
    navigation : true,
    slideSpeed : 300,
    paginationSpeed : 900,
    singleItem:true,
    items : 1,
    autoplay: true,
    autoplayTimeout: 5000,
    autoplayHoverPause: true,
    loop: true,
  });

  $('#back-to-top').click(function(){
    return $("body, html").animate({scrollTop:0}, 400);
  });

  $(function(){$('[data-toggle="tooltip"]').tooltip()});
  
  $('#stories-table').DataTable({
    "columnDefs": [
      { "searchable": false, "targets": 3 }
    ]
  });

  $('#chapters-table').DataTable({
    "columnDefs": [
      { "searchable": false, "targets": 2 }
    ]
  });

  $('#livesearch_input').hsearchbox({
    url: $('#livesearch_form').attr('action'),
    param: 'search',
    dom_id: '#livesearch_dom',
    loading_css: '#livesearch_loading',
  });

  if (window.document.getElementById("chapter_content")){
    var history_pos = $('#position').val();
    if (history_pos > 0){
      confirm = confirm("Do you want continue reading?");
      if (confirm){
        $('html,body').animate({scrollTop: history_pos}, 400);
      }
    }
    var chapter = window.location.pathname.split("/")[2];

    var update = setInterval(function(){
      var pos = $('html,body').scrollTop();
      console.log(pos);
      $.ajax({
        type: 'put',
        url: '/updatehistory',
        dataType: 'json',
        data: {pos: pos, chapter: chapter}
      })
    },3000);
  }
});
