module PhotosHelper
  def format_time(datetime)
    return 'No shooting date' if datetime.nil?

    datetime.to_formatted_s(:long)
  end
end
