class Scraper
  attr_accessor :jobs

  URL = "https://www.glassdoor.com/Best-Jobs-in-America-LST_KQ0,20.htm"

  def initialize
    @doc = Nokogiri::HTML(open(URL))
  end

  def scrape_job_page
    @jobs = @doc.search(".padVertLg").collect do |job_doc|
      Job.new({
        :rank => job_doc.search(".num.padRtLg").text.strip.to_i,
        :title => job_doc.search(".h2").text,
        :openings => job_doc.search(".strong").text.split("$")[0].gsub(",", "").to_i,
        :median_base_salary => job_doc.search(".strong").text.split("$")[1].split(".")[0][0..-2].gsub(",", "").to_i
     })
    end
  end
end

