require 'sinatra'
require 'slim'
require 'sinatra/reloader'

set :environment, :production

get '/' do
  # 'hello'

  @favulous = params[:favulous].to_i
  @critical = params[:critical].to_i
  @burst    = params[:burst].to_i
  @hit      = params[:hit].to_i
  @miss     = params[:miss].to_i
  @combo    = params[:combo].to_i

  # 処理
  @total = @favulous + @critical + @burst + @hit + @miss
  if @total > 0

    ### 2 CB ###
    @cb_rate  = (((@favulous + @critical) * 8 + @burst * 4 + @combo * 2) * 10 / @total).floor

    @cb_score = @favulous * 100 + @critical * 50 + @burst * 10
    @cb_rank = case (@favulous + @critical + @burst) * 100 / @total
    when 100;        "S++"
    when (98...100); "S+"
    when (95...98);  "S"
    when (90...95);  "A+"
    when (85...90);  "A"
    when (80...85);  "B+"
    when (75...80);  "B"
    when (70...75);  "C"
    when (65...70);  "D"
    else;            "E"
    end

    ### 2 IIDX ###
    @ex_score = @favulous * 2 + @critical
    @ex_max   = @total * 2

    @miss_count = @hit + @miss

    @dj_level = case @ex_score * 9 / @ex_max
    when (8..9);  "AAA"
    when (7...8); "AA"
    when (6...7); "A"
    when (5...6); "B"
    when (4...5); "C"
    when (3...4); "D"
    when (2...3); "E"
    else;         "F"
    end

    ### 2 ポ ###
    @pm_score =  ((@favulous + @critical * 0.7 + @burst * 0.4) * 100000 / @total).floor
    @pm_rank = case @pm_score
    when (98000..100000); "S"
    when (95000...98000); "AAA"
    when (90000...98000); "AA"
    when (82000...90000); "A"
    when (72000...82000); "B"
    when (62000...72000); "C"
    when (50000...62000); "D"
    else;                 "E"
    end

  end

  slim :index
end
