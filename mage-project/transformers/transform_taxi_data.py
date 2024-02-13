if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):    
    data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    return data


@test
def test_no_zero_pass_count(output, *args):
    assert output['passenger_count'].isin([0]).sum() == 0, 'No zero passengers!'

@test
def test_no_zero_trips(output, *args):
    assert output['trip_distance'].isin([0]).sum() == 0, 'No zero trips!'

@test
def test_vendor_is_1_or_2(output, *args):
    assert output['VendorID'].between(1, 2).all(), 'No other vendors!'