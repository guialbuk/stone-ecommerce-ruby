class QuerySaleAntiFraudAnalysisHistoryData
  # Status do antifraude
  attr_accessor :AntiFraudAnalysisStatus

  @@AntiFraudAnalysisStatusEnum = {
    :Undefined => '0',
    :PendingFraudAnalysisRequirement => '1',
    :FraudAnalysisRequirementSent => '2',
    :Approved => '3',
    :Reproved => '4',
    :PendingManualAnalysis => '5',
    :NoTransactionToAnalyse => '6',
    :FraudAnalysisWithError => '7'
  }

  # Código de retorno do serviço de anti fraude
  attr_accessor :ReturnCode

  # Status de retorno
  attr_accessor :ReturnStatus

  # Menssagem de retorno
  attr_accessor :ReturnMessage

  # Pontuação
  attr_accessor :Score

  # Data da alteração de status
  attr_accessor :StatusChangedDate

  def initialize
    @AntiFraudAnalysisStatus = self.AntiFraudAnalysisStatusEnum
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
