class Hash
  def recursive_find_by_key(key)
    stack = [ self ]

    while (to_search = stack.pop)
      to_search.each do | k,v |
        return v if (k == key)

        if(v.respond_to?(:recursive_find_by_key))
          stack << v
        end
      end
     end
   end
end
