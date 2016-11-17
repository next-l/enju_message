# -*- encoding: utf-8 -*-
require 'spec_helper'

describe MessageTemplate do
  # pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: message_templates
#
#  id         :integer          not null, primary key
#  status     :string           not null
#  title      :text             not null
#  body       :text             not null
#  position   :integer
#  locale     :string           default("en")
#  created_at :datetime
#  updated_at :datetime
#
