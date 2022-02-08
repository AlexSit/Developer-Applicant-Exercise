module Template
  MINIMUM_CODE_LENGTH = 8

  def template(template, code)
    validate_template(template)
    validate_code(code)

    altcode = transform_code_into_altcode(code)

    template = substitute_first_occurence(template, "%CODE%", code)
    template = substitute_first_occurence(template, "%ALTCODE%", altcode)
    template
  end

  private

  def validate_template(template)
    raise ArgumentError.new(
      "template must not be an empty string"
    ) if !template || template.empty?
  end

  def validate_code(req_id)
    raise ArgumentError.new(
      "req_id must not be nil"
    ) if !req_id

    raise ArgumentError.new(
      "req_id must be at least #{MINIMUM_CODE_LENGTH} characters long, got #{req_id.length}"
    ) if req_id.length < MINIMUM_CODE_LENGTH
  end

  def transform_code_into_altcode(code)
    code[0..4] + "-" + code[5..7]
  end

  def substitute_first_occurence(template, keyword, value) # 3 parameters, make a class
    template_split_begin = template.index(keyword) # choose better names
    return template if template_split_begin.nil?

    template_split_end = template_split_begin + keyword.length

    template_part_one = ''
    template_part_two =
      String.new(template[template_split_end..template.length])

    template_part_one_exists = template_split_begin > 0
    if template_part_one_exists # make a note about using built-in functions
      template_part_one_end_index = template_split_begin - 1
      template_part_one =
        String.new(template[0..(template_part_one_end_index)])
    end

    template_part_one + value + template_part_two
  end

end
