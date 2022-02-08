module Template
  def template(source_template, req_id)
    template = String.new(source_template)
    code = String.new(req_id)
    altcode = code[0..4] + "-" + code[5..7]

    template = substitute_first_occurence(template, "%CODE%", code)
    template = substitute_first_occurence(template, "%ALTCODE%", altcode)
    template
  end

  private 

  def substitute_first_occurence(template, keyword, value)
    template_split_begin = template.index(keyword)
    template_split_end = template_split_begin + keyword.length

    template_part_one = ''
    template_part_two =
      String.new(template[template_split_end..template.length])

    if template_split_begin > 0
      template_part_one =
        String.new(template[0..(template_split_begin-1)])
    end

    template_part_one + value + template_part_two
  end
end
