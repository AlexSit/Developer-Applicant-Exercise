module Template
  MINIMUM_CODE_LENGTH = 8

  class TemplateFiller
    def initialize(template)
      @template=template
    end

    def fill(match_pattern, replacement)
      @template = substitute_first_occurence(match_pattern, replacement)
    end

    def get_template()
      @template
    end

    private

    # NOTE: I could have used built-in regex/replace functions and although this can be done easily
    # I'd rather demonstrate my refactoring using this "manual" template transformation
    def substitute_first_occurence(match_pattern, replacement)
      template_split_begin = @template.index(match_pattern)
      return @template if template_split_begin.nil?

      template_split_end = template_split_begin + match_pattern.length

      template_part_one = make_template_part_one(template_split_begin)
      template_part_two = make_template_part_two(template_split_end)

      template_part_one + replacement + template_part_two
    end

    def make_template_part_one(template_split_begin)
      template_part_one_is_empty = template_split_begin == 0
      return '' if template_part_one_is_empty

      template_part_one_end_index = template_split_begin - 1
      substring(@template, 0, template_part_one_end_index)
    end

    def make_template_part_two(template_split_end)
      substring(@template, template_split_end, @template.length)
    end

    def substring(str, start_index, end_index)
      String.new(str[start_index..end_index])
    end
  end

  def template(template, code)
    validate_source_template(template)
    validate_code(code)

    altcode = transform_code_into_altcode(code)

    template_filler = TemplateFiller.new(template)
    template_filler.fill("%CODE%", code)
    template_filler.fill("%ALTCODE%", altcode)
    template_filler.get_template()
  end

  def validate_source_template(template)
    raise ArgumentError.new(
      "template must not be an empty string"
    ) if !template || template.empty?
  end

  def validate_code(code)
    validate_code_is_not_nil(code)
    validate_code_is_long_enough(code)
  end

  def validate_code_is_not_nil(code)
    raise ArgumentError.new(
      "code must not be nil"
    ) if !code
  end

  def validate_code_is_long_enough(code)
    raise ArgumentError.new(
      "code must be at least #{MINIMUM_CODE_LENGTH} characters long, got #{code.length}"
    ) if code.length < MINIMUM_CODE_LENGTH
  end

  def transform_code_into_altcode(code)
    code[0..4] + "-" + code[5..7]
  end
end

