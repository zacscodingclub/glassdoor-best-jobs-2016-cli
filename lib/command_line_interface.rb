class CommandLineInterface
  
  def call
    puts "BRB, fetching the Glassdoor Top 25 Jobs 2016 information." 

    make_jobs
    cli
  end

  def make_jobs
    job_array = Scraper.new.scrape_job_page
  end

  def cli
    input = ""

    until input == "exit"
      display_options
      input = gets.chomp

      process_option(input)
    end
  end

  def display_options
    puts "Sort By: ('exit' to leave)"
    puts "   Rank"
    puts "   Title"
    puts "   Salary"
    puts "   Openings"
    puts "   Market Size"
    puts "   Search"
  end

  def process_option(input)
    case input.downcase
      when "rank"
        show_jobs(Job.sort_by_rank)
      when "title"
        show_jobs(Job.sort_by_title)
      when "salary"
        show_jobs(Job.sort_by_base_salary)
      when "openings"
        show_jobs(Job.sort_by_most_openings)
      when "market size"
        show_jobs(Job.sort_by_market_size)
      when "search"
        show_jobs(Job.search_by_title(gets.chomp))
      when "exit"
        puts "Goodbye!"
      else
        puts "I couldn't understand that, please try again."
    end
  end

  def show_jobs(jobs=Job.all)
    width = 55
    puts ''
    puts 'Results:'.ljust(31)+'  Total Openings: '+"#{Job.total_openings/1000} k"+('Total Market:'+"#{(Job.total_market_size / 1000000000).to_f} B").rjust(width/2.1)
    puts '='*80
    puts 'Job Title'.ljust(28)+'Rank'.rjust(width/4) + 'Openings'.rjust(width/4) + 'Base Salary'.rjust(width/4) + 'Market Size'.rjust(width/4)
    puts '='*80
    jobs.each do |job|
      puts job.title.ljust(28) +job.rank.to_s.rjust(width/4) + job.openings.to_s.rjust(width/4) + "#{job.median_base_salary / 1000} k".rjust(width/4) + "#{job.market_size / 1000000} M".rjust(width/4)
    end
    puts '='*80
    puts ''
  end
end