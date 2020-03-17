class DownloadWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  require "zip"

  def perform story_id
    story = Story.find_by id: story_id
    pdf_options = {
      layout: Settings.pdf_option.layout,
      encoding: Settings.pdf_option.encoding,
      margin: {
        top: Settings.pdf_option.margin_top,
        bottom: Settings.pdf_option.margin_bottom,
        left: Settings.pdf_option.margin_left,
        right: Settings.pdf_option.margin_right
      }
    }
    snake_case_name = story.name.gsub(" ", "_")
    input_folder = Rails.root.join "public/#{snake_case_name}"
    zipfile_name = Rails.root.join "public/#{snake_case_name}.zip"

    unless Dir.exist? input_folder
      Dir.mkdir input_folder

      story.chapters.each do |chapter|
        html = ActionController::Base.render template: "chapters/chapter_pdf.html.erb",
          layout: Settings.pdf_option.layout, locals: {chapter: chapter}
        pdf = WickedPdf.new.pdf_from_string html, pdf_options
        save_path = File.join(input_folder,
          "Chapter_#{chapter.chapter_number}_#{chapter.name}.pdf")
        File.open(save_path, "wb") do |file|
          file << pdf
        end
      end

      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        Dir.children(input_folder).each do |file|
          zipfile.add file, File.join(input_folder, file)
        end
      end
    end
  end
end
