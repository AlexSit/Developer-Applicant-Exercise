module Template
  MINIMUM_CODE_LENGTH = 8

  def template(source_template, req_id)
    validate_template(source_template)
    validate_req_id(req_id)

    template = String.new(source_template)
    code = String.new(req_id)
    altcode = code[0..4] + "-" + code[5..7]

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

  def validate_req_id(req_id)
    raise ArgumentError.new(
      "req_id must not be nil"
    ) if !req_id

    raise ArgumentError.new(
      "req_id must be at least #{MINIMUM_CODE_LENGTH} characters long, got #{req_id.length}"
    ) if req_id.length < MINIMUM_CODE_LENGTH
  end

  def substitute_first_occurence(template, keyword, value) # 3 parameters, make a class
    template_split_begin = template.index(keyword) # choose better names
    return template if template_split_begin.nil?

    template_split_end = template_split_begin + keyword.length

    template_part_one = ''
    template_part_two =
      String.new(template[template_split_end..template.length])

    if template_split_begin > 0 # make a note about using built-in functions
      template_part_one =
        String.new(template[0..(template_split_begin-1)]) # -1s
    end

    template_part_one + value + template_part_two
  end
end
