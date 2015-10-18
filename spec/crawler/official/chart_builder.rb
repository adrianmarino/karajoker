require 'spec_helper'

module Crawler::Official
  describe ChartBuilder do
    context 'when select rock and metal chart in last year' do
      subject { described_class.new(name: Chart::ROCK_AND_METAL_SINGLES, at: '2014-06-01'.to_date).build }

      it 'get url' do
        expect(subject.url).to eq('http://www.officialcharts.com/charts/rock-and-metal-singles-chart/20140601')
      end
    end
  end
end
