# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list
json.extract! @board, :title, :id

json.lists @board.lists do |list|
  json.extract! list, :title, :id

  json.cards list.cards do |card|
    json.extract! card, :title, :id
  end
end
