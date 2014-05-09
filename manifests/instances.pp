# Create all virtual hosts from hiera
class role_col::instances (
    $instances,
)
{
  create_resources('apache::vhost', $instances)
}
