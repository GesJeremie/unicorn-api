defmodule Unicorn.MemorableNameHelper do    
  @moduledoc """
  Generate memorable name to be used as ID.
  """
  @adjectives ~w(afraid ancient angry average bad big bitter black blue brave breezy bright brown calm chatty chilly clever cold cowardly cuddly curly curvy dangerous dry dull empty evil fast fat fluffy foolish fresh friendly funny fuzzy gentle giant good great green grumpy happy hard heavy helpless honest horrible hot hungry itchy jolly kind lazy light little loud lovely lucky massive mean mighty modern moody nasty neat nervous new nice odd old orange ordinary perfect pink plastic polite popular pretty proud purple quick quiet rare red rotten rude selfish serious shaggy sharp short shy silent silly slimy slippery smart smooth soft sour spicy splendid spotty stale strange strong stupid sweet swift tall tame tasty tender terrible thin tidy tiny tough tricky ugly unlucky warm weak wet white wicked wise witty wonderful yellow young) 
  @nouns ~w(ape baboon badger balloon bat bear bird bobcat boy broccoli brownie bulldog bullfrog carrot cat catfish cheetah chicken chipmunk cobra cougar cow crab cream cyclone deer dingo dodo dog dolphin donkey donut dragon dragonfly drug duck eagle earwig eel elephant emu falcon fireant firefox fish fly fox frog gecko girl goat goose grasshopper horse hound husky ice impala insect jellyfish joke kangaroo ladybug liger lion lionfish lizard man mayfly mole monkey monster moose moth mouse mule newt octopus otter owl pancake panda panther parrot penguin pig poet potato princess pug puma quail rabbit rat rattlesnake robin seahorse sheep shrimp skunk sky sloth snail snake space spiderman spiral squid starfish stingray swan termite tiger toast toaster tongue towel treefrog turkey turtle unicorn vampirebat waffle walrus warthog wasp weed wolverine woman wombat yak zebra)

  @doc """
  Generate a memorable name
  """
  def generate do
    "#{pick_adjective}-#{pick_noun}-#{pick_number(3)}"
  end

  defp pick_adjective do
    Enum.random(@adjectives) 
  end 

  defp pick_noun do
    Enum.random(@nouns)  
  end

  defp pick_digit do
    Enum.random(0..9)
  end

  defp pick_number(nb_digits) do
    1..nb_digits |> Enum.map(fn _ -> pick_digit end) |> Enum.join
  end

end