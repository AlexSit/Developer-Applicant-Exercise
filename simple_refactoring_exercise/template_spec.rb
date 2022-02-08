require_relative 'template'

describe Template do
  include Template

  it "should substitute %CODE% and %ALTCODE% in the template" do
    expect(template('Code is %CODE%; alt code is %ALTCODE%', '5678901234')).to eq 'Code is 5678901234; alt code is 56789-012'
  end

  it "should substitute '%CODE%%ALTCODE%'" do
    expect(template('%CODE%%ALTCODE%', '5678901234')).to eq '567890123456789-012'
  end

  it "should substitute '%ALTCODE%%CODE%'" do
    expect(template('%ALTCODE%%CODE%', '5678901234')).to eq '56789-0125678901234'
  end

  it "should throw an exception when %CODE% has fewer than 8 characters" do
    expect { template('Code is %CODE%; alt code is %ALTCODE%', '1234567') }.to raise_error(ArgumentError)
  end

  it "should throw an exception when template is nil" do
    expect { template(nil, '5678901234') }.to raise_error(ArgumentError)
  end

  it "should throw an exception when template is an empty string" do
    expect { template('', '5678901234') }.to raise_error(ArgumentError)
  end

  # no %CODE% and/or no %ALTCODE%

  # empty strings %CODE% and/or no %ALTCODE%

  # multiple %CODE% and %ALTCODE%

  

end
