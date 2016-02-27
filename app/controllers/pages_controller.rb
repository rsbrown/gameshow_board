class PagesController < ApplicationController

  def home
    @board = Board.first
    @board_data = @board.data['categories']
  end

  def answer
    @board = Board.first
    @board_data = @board.data['categories']
    @board_data[params[:cat_num].to_i]["questions"][params[:q_num].to_i]["ans"] = "answered"
    @board.save!
    render text: "ok"
  end

  def reset
    @board = Board.first
    @board_data = @board.data['categories']
    @board_data.each do |cat|
      cat["questions"].each do |q_data|
        q_data.delete "ans"
      end
    end
    @board.save!
    redirect_to root_path
  end

  def edit
    @board = Board.first
    @board_data = @board.data['categories']
  end

  def save
    @board = Board.first
    @board['name'] = params["title"]

    params["categories"].keys.each do |cat_num|
      cat = @board.data["categories"][cat_num.to_i]
      cat["name"] = params["categories"][cat_num]
    end

    params["values"].keys.each do |cat_num|
      cat = @board.data["categories"][cat_num.to_i]
      params["values"][cat_num].keys.each do |q_num|
        cat["questions"][q_num.to_i]["value"] = params["values"][cat_num][q_num]
      end
    end

    params["questions"].keys.each do |cat_num|
      cat = @board.data["categories"][cat_num.to_i]
      params["questions"][cat_num].keys.each do |q_num|
        cat["questions"][q_num.to_i]["q"] = params["questions"][cat_num][q_num]
      end
    end

    params["answers"].keys.each do |cat_num|
      cat = @board.data["categories"][cat_num.to_i]
      params["answers"][cat_num].keys.each do |q_num|
        cat["questions"][q_num.to_i]["a"] = params["answers"][cat_num][q_num]
      end
    end

    params["answered"] ||= {} 
    params["answered"].keys.each do |cat_num|
      cat = @board.data["categories"][cat_num.to_i]
      params["answered"][cat_num].keys.each do |q_num|
        cat["questions"][q_num.to_i]["ans"] = "answered" if params["answered"][cat_num][q_num].present?
      end
    end

    @board.save!

    redirect_to root_url
  end

end
