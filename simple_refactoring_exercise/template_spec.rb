require_relative 'template'

describe Template do
  include Template

  it "should substitute %CODE% and %ALTCODE% in the template" do
    expect(template('Code is %CODE%; alt code is %ALTCODE%', '5678901234')).to eq 'Code is 5678901234; alt code is 56789-012'
  end

  it "should substitute '%CODE%%ALTCODE%'" do
    expect(template('%CODE%%ALTCODE%', '5678901234')).to eq '567890123456789-012'
  end

end
