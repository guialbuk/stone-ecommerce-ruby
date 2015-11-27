class QuerySaleAntiFraudAnalysisData
  # Indica se o serviço de antifraude está habilitado
  attr_accessor :IsAntiFraudEnabled

  # Código do serviço de antifraude
  attr_accessor :AntiFraudServiceCode

  # Nome do serviço de antifraude
  attr_accessor :AntiFraudServiceName

  # Status da análise de antifraude
  attr_accessor :AntiFraudAnalysisStatus

  @@AntiFraudAnalysisStatus = {
    :Undefined => '0',
    :PendingFraudAnalysisRequirement => '1',
    :FraudAnalysisRequirementSent => '2',
    :Approved => '3',
    :Reproved => '4',
    :PendingManualAnalysis => '5',
    :NoTransactionToAnalyse => '6',
    :FraudAnalysisWithError => '7'
  }

  # Código de retorno do serviço de antifraude
  attr_accessor :ReturnCode

  # Status do retorno do antifraude
  attr_accessor :ReturnStatus

  # Mensagem de retorno do antifraude
  attr_accessor :ReturnMessage

  # Pontuação do comprador
  attr_accessor :Score

  # Histórico da análise de antifraude
  attr_accessor :HistoryCollection

  def initialize
    @AntiFraudAnalysisStatus = self.AntiFraudAnalysisStatusEnum
    @HistoryCollection = QuerySaleAntiFraudAnalysisHistoryData.new
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
