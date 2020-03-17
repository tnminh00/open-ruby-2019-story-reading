class DownloadController < ApplicationController
  before_action :load_chapter, only: :chapter
  before_action :load_story, only: :story

  def chapter
    respond_to do |format|
      format.pdf do
        render pdf: "#{@chapter.story_name}_chapter_#{@chapter.chapter_number}",
        template: "chapters/chapter_pdf.html.erb",
        locals: {chapter: @chapter},
        disposition: Settings.pdf_option.disposition,
        layout: Settings.pdf_option.layout,
        encoding: Settings.pdf_option.encoding,
        margin: {
          top: Settings.pdf_option.margin_top,
          bottom: Settings.pdf_option.margin_bottom,
          left: Settings.pdf_option.margin_left,
          right: Settings.pdf_option.margin_right
        }
      end
    end
  end

  def export_story
    respond_to do |format|
      format.js
      format.json do
        job_id = DownloadWorker.perform_async params[:id]
        render json: {
          story_id: params[:id],
          jid: job_id
        }
      end
    end
  end

  def export_status
    job_id = params[:job_id]
    job_status = Sidekiq::Status.get_all(job_id).symbolize_keys

    render json: {
      status: job_status[:status],
    }
  end

  def story
    snake_case_name = @story.name.gsub(" ", "_")
    input_folder = Rails.root.join "public/#{snake_case_name}"
    zipfile_name = Rails.root.join "public/#{snake_case_name}.zip"
    send_file zipfile_name, disposition: "attachment"
  end
end
