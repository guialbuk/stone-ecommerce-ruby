module Gateway

  class HeaderParser
    def Parse(elements)
      if elements.length < 4
        throw('The expected parameter count is 4')
      end

      header = Header.new
      header.TransactionProcessedDate = Date.parse(elements[1]).strftime('%Y%m%d')
      header.ReportFileCreateDate = Date.parse(elements[2]).strftime('%Y%m%d %H:%M:%S')
      header.Version = elements[3].chomp

      return header
    end
  end
end