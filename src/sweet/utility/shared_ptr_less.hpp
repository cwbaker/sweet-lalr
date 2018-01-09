#ifndef SWEET_UTILITY_SHARED_PTR_LESS_HPP_INCLUDED
#define SWEET_UTILITY_SHARED_PTR_LESS_HPP_INCLUDED

#include <memory>

namespace sweet
{

namespace utility
{

/**
// Indirectly compare objects through two `std::shared_ptr<>` objects.
*/
template <class Type>
class shared_ptr_less
{
public:
    bool operator()( const std::shared_ptr<Type>& lhs, const std::shared_ptr<Type>& rhs ) const
    {
        return *lhs < *rhs;
    }
};

}

using utility::shared_ptr_less;

}

#endif