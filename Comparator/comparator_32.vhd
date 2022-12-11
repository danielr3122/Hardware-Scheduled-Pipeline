-- -------------------------------------------------------------------------
-- -- Daniel Rosenhamer
-- -------------------------------------------------------------------------
-- -- comparator_32.vhd
-- -------------------------------------------------------------------------
-- -- DESCRIPTION: This file contains an implementation of our compatator 
-- --              unit.
-- ------------------------------------------------------------------------

-- library IEEE;
-- use IEEE.std_logic_1164.all;

-- entity comparator_32 is
--     port(i_d0 : in std_logic_vector(31 downto 0);
--          i_d1 : in std_logic_vector(31 downto 0);
--          o_o  : out std_logic);
-- end comparator_32;

-- architecture mixed of comparator_32 is

--     signal a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, aa, ab, ac, ad, ae, af : std_logic;

--     begin
--         a <= i_d0(0) xor i_d1(0);
--         b <= i_d0(1) xor i_d1(1);
--         c <= i_d0(2) xor i_d1(2);
--         d <= i_d0(3) xor i_d1(3);
--         e <= i_d0(4) xor i_d1(4);
--         f <= i_d0(5) xor i_d1(5);
--         g <= i_d0(6) xor i_d1(6);
--         h <= i_d0(7) xor i_d1(7);
--         i <= i_d0(8) xor i_d1(8);
--         j <= i_d0(9) xor i_d1(9);
--         k <= i_d0(10) xor i_d1(10);
--         l <= i_d0(11) xor i_d1(11);
--         m <= i_d0(12) xor i_d1(12);
--         n <= i_d0(13) xor i_d1(13);
--         o <= i_d0(14) xor i_d1(14);
--         p <= i_d0(15) xor i_d1(15);
--         q <= i_d0(16) xor i_d1(16);
--         r <= i_d0(17) xor i_d1(17);
--         s <= i_d0(18) xor i_d1(18);
--         t <= i_d0(19) xor i_d1(19);
--         u <= i_d0(20) xor i_d1(20);
--         v <= i_d0(21) xor i_d1(21);
--         w <= i_d0(22) xor i_d1(22);
--         x <= i_d0(23) xor i_d1(23);
--         y <= i_d0(24) xor i_d1(24);
--         z <= i_d0(25) xor i_d1(25);
--         aa <= i_d0(26) xor i_d1(26);
--         ab <= i_d0(27) xor i_d1(27);
--         ac <= i_d0(28) xor i_d1(28);
--         ad <= i_d0(29) xor i_d1(29);
--         ae <= i_d0(30) xor i_d1(30);
--         af <= i_d0(31) xor i_d1(31);

--         o_o <= not(a or b or c or d or e or f or g or h or i or j or k or l or m or n or o or p or q or r or s or t or u or v or w or x or y or z or aa or ab or ac or ad or ae or af);

-- end mixed;