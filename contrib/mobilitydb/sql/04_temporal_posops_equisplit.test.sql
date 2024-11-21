-------------------------------------------------------------------------------
--
-- This MobilityDB code is provided under The PostgreSQL License.
-- Copyright (c) 2016-2024, Université libre de Bruxelles and MobilityDB
-- contributors
--
-- MobilityDB includes portions of PostGIS version 3 source code released
-- under the GNU General Public License (GPLv2 or later).
-- Copyright (c) 2001-2024, PostGIS contributors
--
-- Permission to use, copy, modify, and distribute this software and its
-- documentation for any purpose, without fee, and without a written
-- agreement is hereby granted, provided that the above copyright notice and
-- this paragraph and the following two paragraphs appear in all copies.
--
-- IN NO EVENT SHALL UNIVERSITE LIBRE DE BRUXELLES BE LIABLE TO ANY PARTY FOR
-- DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
-- LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
-- EVEN IF UNIVERSITE LIBRE DE BRUXELLES HAS BEEN ADVISED OF THE POSSIBILITY
-- OF SUCH DAMAGE.
--
-- UNIVERSITE LIBRE DE BRUXELLES SPECIFICALLY DISCLAIMS ANY WARRANTIES,
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
-- AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON
-- AN "AS IS" BASIS, AND UNIVERSITE LIBRE DE BRUXELLES HAS NO OBLIGATIONS TO
-- PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

DROP INDEX IF EXISTS tbl_tbool_mrtree_idx;
DROP INDEX IF EXISTS tbl_ttext_mrtree_idx;

DROP INDEX IF EXISTS tbl_tbool_mquadtree_idx;
DROP INDEX IF EXISTS tbl_ttext_mquadtree_idx;

DROP INDEX IF EXISTS tbl_tbool_mkdtree_idx;
DROP INDEX IF EXISTS tbl_ttext_mkdtree_idx;

-------------------------------------------------------------------------------

DROP TABLE IF EXISTS test_posops;
CREATE TABLE test_posops(
  op CHAR(3),
  leftarg TEXT,
  rightarg TEXT,
  no_idx BIGINT,
  mrtree_idx BIGINT,
  mquadtree_idx BIGINT,
  mkdtree_idx BIGINT
);

-------------------------------------------------------------------------------
-- Before
-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '<<#', 'tstzspan', 'tbool', COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t <<# getTime(temp);
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '<<#', 'tstzspan', 'ttext', COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t <<# getTime(temp);

-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '<<#', 'tbool', 'tstzspan', COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) <<# t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '<<#', 'tbool', 'tbool', COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) <<# getTime(t2.temp);

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '<<#', 'ttext', 'tstzspan', COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) <<# t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '<<#', 'ttext', 'ttext', COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) <<# getTime(t2.temp);

-------------------------------------------------------------------------------
-- Overbefore
-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '&<#', 'tstzspan', 'tbool', COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t &<# getTime(temp);
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '&<#', 'tstzspan', 'ttext', COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t &<# getTime(temp);

-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '&<#', 'tbool', 'tstzspan', COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) &<# t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '&<#', 'tbool', 'tbool', COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) &<# getTime(t2.temp);

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '&<#', 'ttext', 'tstzspan', COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) &<# t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '&<#', 'ttext', 'ttext', COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) &<# getTime(t2.temp);

-------------------------------------------------------------------------------
-- After
-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#>>', 'tstzspan', 'tbool', COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #>> getTime(temp);
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#>>', 'tstzspan', 'ttext', COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #>> getTime(temp);

-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#>>', 'tbool', 'tstzspan', COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #>> t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#>>', 'tbool', 'tbool', COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #>> getTime(t2.temp);

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#>>', 'ttext', 'tstzspan', COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #>> t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#>>', 'ttext', 'ttext', COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #>> getTime(t2.temp);

-------------------------------------------------------------------------------
-- Overafter
-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#&>', 'tstzspan', 'tbool', COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #&> getTime(temp);
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#&>', 'tstzspan', 'ttext', COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #&> getTime(temp);

-------------------------------------------------------------------------------

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#&>', 'tbool', 'tstzspan', COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #&> t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#&>', 'tbool', 'tbool', COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #&> getTime(t2.temp);

INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#&>', 'ttext', 'tstzspan', COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #&> t;
INSERT INTO test_posops(op, leftarg, rightarg, no_idx)
SELECT '#&>', 'ttext', 'ttext', COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #&> getTime(t2.temp);

-------------------------------------------------------------------------------

CREATE INDEX tbl_tbool_mrtree_idx ON tbl_tbool
  USING MGIST(temp tbool_mrtree_equisplit_ops(num_spans=3));
CREATE INDEX tbl_ttext_mrtree_idx ON tbl_ttext
  USING MGIST(temp ttext_mrtree_equisplit_ops(num_spans=3));

-------------------------------------------------------------------------------
-- Before
-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t <<# getTime(temp) )
WHERE op = '<<#' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t <<# getTime(temp) )
WHERE op = '<<#' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) <<# t )
WHERE op = '<<#' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) <<# getTime(t2.temp) )
WHERE op = '<<#' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) <<# t )
WHERE op = '<<#' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) <<# getTime(t2.temp) )
WHERE op = '<<#' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- Overbefore
-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t &<# getTime(temp) )
WHERE op = '&<#' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t &<# getTime(temp) )
WHERE op = '&<#' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) &<# t )
WHERE op = '&<#' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) &<# getTime(t2.temp) )
WHERE op = '&<#' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) &<# t )
WHERE op = '&<#' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) &<# getTime(t2.temp) )
WHERE op = '&<#' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- After
-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #>> getTime(temp) )
WHERE op = '#>>' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #>> getTime(temp) )
WHERE op = '#>>' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #>> t )
WHERE op = '#>>' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #>> getTime(t2.temp) )
WHERE op = '#>>' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #>> t )
WHERE op = '#>>' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #>> getTime(t2.temp) )
WHERE op = '#>>' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- Overafter
-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #&> getTime(temp) )
WHERE op = '#&>' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #&> getTime(temp) )
WHERE op = '#&>' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #&> t )
WHERE op = '#&>' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #&> getTime(t2.temp) )
WHERE op = '#&>' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #&> t )
WHERE op = '#&>' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mrtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #&> getTime(t2.temp) )
WHERE op = '#&>' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

DROP INDEX tbl_tbool_mrtree_idx;
DROP INDEX tbl_ttext_mrtree_idx;

-------------------------------------------------------------------------------

CREATE INDEX tbl_tbool_mquadtree_idx ON tbl_tbool
  USING MSPGIST(temp tbool_mquadtree_equisplit_ops(num_spans=3));
CREATE INDEX tbl_ttext_mquadtree_idx ON tbl_ttext
  USING MSPGIST(temp ttext_mquadtree_equisplit_ops(num_spans=3));

-------------------------------------------------------------------------------
-- Before
-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t <<# getTime(temp) )
WHERE op = '<<#' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t <<# getTime(temp) )
WHERE op = '<<#' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) <<# t )
WHERE op = '<<#' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) <<# getTime(t2.temp) )
WHERE op = '<<#' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) <<# t )
WHERE op = '<<#' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) <<# getTime(t2.temp) )
WHERE op = '<<#' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- Overbefore
-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t &<# getTime(temp) )
WHERE op = '&<#' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t &<# getTime(temp) )
WHERE op = '&<#' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) &<# t )
WHERE op = '&<#' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) &<# getTime(t2.temp) )
WHERE op = '&<#' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) &<# t )
WHERE op = '&<#' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) &<# getTime(t2.temp) )
WHERE op = '&<#' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- After
-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #>> getTime(temp) )
WHERE op = '#>>' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #>> getTime(temp) )
WHERE op = '#>>' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #>> t )
WHERE op = '#>>' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #>> getTime(t2.temp) )
WHERE op = '#>>' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #>> t )
WHERE op = '#>>' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #>> getTime(t2.temp) )
WHERE op = '#>>' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- Overafter
-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #&> getTime(temp) )
WHERE op = '#&>' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #&> getTime(temp) )
WHERE op = '#&>' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #&> t )
WHERE op = '#&>' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #&> getTime(t2.temp) )
WHERE op = '#&>' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #&> t )
WHERE op = '#&>' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mquadtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #&> getTime(t2.temp) )
WHERE op = '#&>' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

DROP INDEX tbl_tbool_mquadtree_idx;
DROP INDEX tbl_ttext_mquadtree_idx;

-------------------------------------------------------------------------------

CREATE INDEX tbl_tbool_mkdtree_idx ON tbl_tbool
  USING MSPGIST(temp tbool_mkdtree_equisplit_ops(num_spans=3));
CREATE INDEX tbl_ttext_mkdtree_idx ON tbl_ttext
  USING MSPGIST(temp ttext_mkdtree_equisplit_ops(num_spans=3));

-------------------------------------------------------------------------------
-- Before
-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t <<# getTime(temp) )
WHERE op = '<<#' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t <<# getTime(temp) )
WHERE op = '<<#' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) <<# t )
WHERE op = '<<#' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) <<# getTime(t2.temp) )
WHERE op = '<<#' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) <<# t )
WHERE op = '<<#' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) <<# getTime(t2.temp) )
WHERE op = '<<#' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- Overbefore
-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t &<# getTime(temp) )
WHERE op = '&<#' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t &<# getTime(temp) )
WHERE op = '&<#' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) &<# t )
WHERE op = '&<#' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) &<# getTime(t2.temp) )
WHERE op = '&<#' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) &<# t )
WHERE op = '&<#' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) &<# getTime(t2.temp) )
WHERE op = '&<#' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- After
-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #>> getTime(temp) )
WHERE op = '#>>' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #>> getTime(temp) )
WHERE op = '#>>' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #>> t )
WHERE op = '#>>' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #>> getTime(t2.temp) )
WHERE op = '#>>' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #>> t )
WHERE op = '#>>' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #>> getTime(t2.temp) )
WHERE op = '#>>' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------
-- Overafter
-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_tbool WHERE t #&> getTime(temp) )
WHERE op = '#&>' AND leftarg = 'tstzspan' AND rightarg = 'tbool';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tstzspan, tbl_ttext WHERE t #&> getTime(temp) )
WHERE op = '#&>' AND leftarg = 'tstzspan' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool, tbl_tstzspan WHERE getTime(temp) #&> t )
WHERE op = '#&>' AND leftarg = 'tbool' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_tbool t1, tbl_tbool t2 WHERE getTime(t1.temp) #&> getTime(t2.temp) )
WHERE op = '#&>' AND leftarg = 'tbool' AND rightarg = 'tbool';

UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext, tbl_tstzspan WHERE getTime(temp) #&> t )
WHERE op = '#&>' AND leftarg = 'ttext' AND rightarg = 'tstzspan';
UPDATE test_posops SET mkdtree_idx = ( SELECT COUNT(*)
FROM tbl_ttext t1, tbl_ttext t2 WHERE getTime(t1.temp) #&> getTime(t2.temp) )
WHERE op = '#&>' AND leftarg = 'ttext' AND rightarg = 'ttext';

-------------------------------------------------------------------------------

DROP INDEX tbl_tbool_mkdtree_idx;
DROP INDEX tbl_ttext_mkdtree_idx;

-------------------------------------------------------------------------------

SELECT * FROM test_posops
WHERE no_idx <> mrtree_idx OR no_idx <> mquadtree_idx OR no_idx <> mkdtree_idx OR
  no_idx IS NULL OR mrtree_idx IS NULL OR mquadtree_idx IS NULL OR mkdtree_idx IS NULL
ORDER BY op, leftarg, rightarg;

DROP TABLE test_posops;

-------------------------------------------------------------------------------