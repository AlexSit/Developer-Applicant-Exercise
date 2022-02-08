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

  it "should raise an argument error when %CODE% has fewer than 8 characters" do
    expect { template('Code is %CODE%; alt code is %ALTCODE%', '1234567') }
      .to raise_error(ArgumentError)
  end

  it "should raise an argument error when template is nil" do
    expect { template(nil, '5678901234') }.to raise_error(ArgumentError)
  end

  it "should raise an argument error when template is an empty string" do
    expect { template('', '5678901234') }.to raise_error(ArgumentError)
  end

  it "should substitute only first occurence of %CODE% and %ALTCODE% in the template" do
    expect(template('Code is %CODE%; %CODE% alt code is %ALTCODE% %ALTCODE%', '5678901234'))
      .to eq 'Code is 5678901234; %CODE% alt code is 56789-012 %ALTCODE%'
  end

  it "should only substitute %ALTCODE% if %CODE% is missing" do
    expect(template('Code is missing; alt code is %ALTCODE%', '5678901234'))
      .to eq 'Code is missing; alt code is 56789-012'
  end

  it "should only substitute %CODE% if %ALTCODE% is missing" do
    expect(template('Code is %CODE%; alt code is missing', '5678901234'))
      .to eq 'Code is 5678901234; alt code is missing'
  end

  it "should not substitute anything if there is no %CODE% or %ALTCODE%" do
    expect(template('Code is code; alt code is alt code', '5678901234'))
      .to eq 'Code is code; alt code is alt code'
  end

  it "should raise an argument error if code is nil" do
    expect {template('Code is %CODE%; alt code is %ALTCODE%', nil)}
      .to raise_error(ArgumentError)
  end

end
