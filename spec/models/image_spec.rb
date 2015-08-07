!#/bin/env ruby

require "../spec_helper.rb"
require "../../models/image.rb"

describe Image do
 filename='../../../sumida.jpg'
 api_config='../../../api.yaml'
  it "test numeric" do
    image = Image.new(filename, api_config)
    expect(image.resize('a', 'b')).to eq ['a', 'b']
    expect(image.resize('a', 0)).to eq ['a', 0]
    expect(image.resize('a', nil)).to eq ['a', nil]
  end
end
