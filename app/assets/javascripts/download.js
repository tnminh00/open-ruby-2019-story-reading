$(document).on('turbolinks:load', function() {
  $(function(){
    $('#download').on('click', function(){
      $('#download').html(I18n.t('stories.story_details.wait'));
      var url = $(this).attr('href')
      $.ajax({
        url: url,
        dataType: 'json'
      }).done(function(response, status){
        if (status === 'success' && response && response.jid) {
          var jobId = response.jid;
          var storyId = response.story_id;
          var intervalName = 'job_' + jobId;

          window[intervalName] = setInterval(function(){
            getExportStatus(jobId, intervalName, storyId);
          }, 1000);
        }
      });
    });

    function getExportStatus(jobId, intervalName, storyId) {
      $.ajax({
        url: '/export_status',
        dataType: 'json',
        data: { 
          job_id: jobId,
          story_id: storyId
        }
      }).done(function(response, status){
        if (status === 'success'){
          if (response.status === 'complete') {
            setTimeout(function() {
              clearInterval(window[intervalName]);
              delete window[intervalName];

              $(location).attr('href', '/download/story/' + storyId);
              $('#download').html(I18n.t('stories.story_details.download'));
              $('#download').attr('href', '/export/story/' + storyId);
            }, 500);
          }
        }
      })
    }
  })
})
