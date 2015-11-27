class AntiFraudAnalysisResult
  # Indica se a análise de antifraude está habilitada
  attr_accessor :IsAntiFraudEnabled

  # Código do serviço de antifraude
  attr_accessor :AntiFraudServiceCode

  # Status da análise do serviço de antifraude
  attr_accessor :AntiFraudAnalysisStatus

  # Código de retorno do antifraude
  attr_accessor :ReturnCode

  # Status de retorno do antifraude
  attr_accessor :ReturnStatus

  # Mensagem de retorno do antifraude
  attr_accessor :Message

  # Pontuação do pedido
  attr_accessor :Score

  # Nome do serviço de antifraude
  attr_accessor :AntiFraudServiceName

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

  def initialize
    @AntiFraudAnalysisStatus = self.AntiFraudAnalysisStatusEnum
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end
