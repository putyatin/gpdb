-- Don't dispatch 'client_encoding'
-- When client_encoding is dispatch to QE, error messages generated in QEs were
-- converted to client_encoding, but QD assumed that they were in server encoding,
-- it will leads to corruption. 

set client_encoding = 'latin1';
create function raise_error(t text) returns void as $$
begin
  raise exception 'raise_error called on "%"', t;
end;
$$ language plpgsql;

select raise_error('funny char ' || chr(196)) from gp_dist_random('gp_id');
