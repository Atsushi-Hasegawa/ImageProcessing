!#/bin/env ruby

require '../spec_helper.rb'
require '../../models/rekognition'

describe Rekognition do
  path = '../../../api.yaml'
  it "test load_file" do
    rekognition = Image.new(path)
    expect(rekognition.face_detect('')).to eq 'ERROR! No image URL '
    expect(rekognition.face_detect(nil)).to eq 'ERROR! No image URL '
  end
  it "test calculation" do
    rekognition = Image.new(path)
    expect(rekognition.calculate(nil, 'hoge')).to eq 'Invalid format type'
  end
end
