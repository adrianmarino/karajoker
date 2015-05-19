require 'spec_helper'

module Karajoker::Crawler::Official
  describe ChartBuilder do
    context "when select rock and metal chart in last year" do
      subject { Chart.select(name: ROCK_AND_METAL_SINGLES, at: Date.parse('2014-06-01')) }

      it "get url" do
        expect(subject.url).to eq(
          'http://www.officialcharts.com/charts/rock-and-metal-singles-chart/20140601')
      end
    end
  end
end
